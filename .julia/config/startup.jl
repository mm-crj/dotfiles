atreplinit() do repl
    try
        @eval begin
            using Logging: global_logger
            using TerminalLoggers: TerminalLogger
            global_logger(TerminalLogger())
        end
    catch
    end
end
