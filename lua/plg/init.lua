local uv = vim.loop
local ui = require("plg.ui")
local plg = {}
local PlgRoot = vim.fn.stdpath("data") .. "/site/pack/plg/start"

vim.fn.mkdir(PlgRoot, "p")

-- Plugin map: repo -> { config, installed }
plg._plugins = {}

-- Register plugin
function plg.use(repo, opts)
    opts = opts or {}
    if not plg._plugins[repo] then
        plg._plugins[repo] = { config = opts.config, done = false }
        -- Handle dependencies recursively
        if opts.dependencies then
            for _, dep in ipairs(opts.dependencies) do
                if type(dep) == "string" then
                    plg.use(dep)
                elseif type(dep) == "table" then
                    plg.use(dep[1], dep)
                end
            end
        end
    end
end

local function run_git_async(cmd, args, cwd, name, on_success)
    local stdout = uv.new_pipe(false)
    local stderr = uv.new_pipe(false)

    local handle
    handle = uv.spawn(cmd, {
        args = args,
        stdio = {nil, stdout, stderr},
        cwd = cwd,
    }, function(code)
        stdout:close()
        stderr:close()
        handle:close()
        vim.schedule(function()
            if code == 0 then
                if on_success then on_success() end
                ui.mark_done(name, true)
            else
                ui.mark_done(name, false)
            end
        end)
    end)

    stdout:read_start(function() end)
    stderr:read_start(function() end)
end

function plg.install()
    local repos = vim.tbl_keys(plg._plugins)
    if #repos == 0 then return end

    ui.open(#repos)

    for _, repo in ipairs(repos) do
        local name = repo:match(".*/(.*)")
        local path = PlgRoot .. "/" .. name

        local function finish()
            vim.opt.runtimepath:append(path)
            plg._plugins[repo].done = true
            local cfg = plg._plugins[repo].config
            if type(cfg) == "function" then
                pcall(cfg)
            end
        end

        if vim.fn.empty(vim.fn.glob(path)) == 1 then
            local url = "https://github.com/" .. repo .. ".git"
            ui.log("Installing " .. name .. "...")
            run_git_async("git", { "clone", "--depth", "1", url, path }, nil, name, finish)
        else
            ui.log("Updating " .. name .. "...")
            run_git_async("git", { "pull", "--ff-only" }, path, name, finish)
        end
    end
end

return plg
