local setup, rest = pcall(require, "rest-nvim")
if not setup then
    return
end

local default_config = {
    result_split_horizontal = true,
    result_split_in_place = true,
    client = "curl",
    env_file = ".env",
    env_pattern = "\\.env$",
    env_edit_command = "tabedit",
    encode_url = true,
    skip_ssl_verification = false,
    custom_dynamic_variables = {},
    jump_to_request = false,
    logs = {
        level = "info",
        save = true,
    },
    result = {
        split = {
            horizontal = true,
            in_place = true,
            stay_in_current_window_after_split = true,
        },
        behavior = {
            decode_url = true,
            show_info = {
                url = true,
                headers = true,
                http_info = true,
                curl_command = true,
            },
            statistics = {
                enable = true,
                stats = {
                    { "total_time",      title = "Time taken:" },
                    { "size_download_t", title = "Download size:" },
                },
            },
            formatters = {
                json = "jq",
                html = function(body)
                    if vim.fn.executable("tidy") == 0 then
                        return body, { found = false, name = "tidy" }
                    end
                    local fmt_body = vim.fn.system({
                        "tidy",
                        "-i",
                        "-q",
                        "--tidy-mark", "no",
                        "--show-body-only", "auto",
                        "--show-errors", "0",
                        "--show-warnings", "0",
                        "-",
                    }, body):gsub("\n$", "")

                    return fmt_body, { found = true, name = "tidy" }
                end,
            },
        },
    },
    highlight = {
        enable = true,
        timeout = 750,
    },
}
rest.setup(default_config)
