local socket = require "skynet.socket"
local skynet = require "skynet"
local sql_cmd = require "sql_command"
local lobby = require "lobby.lobby"
local Log = require "logger"
local call = {}

function call.disconnect_from_battle(account) -- 战斗断开调用
    local fd = lobby.user_data[account].fd
    local addr = lobby.user_data[account].addr
    if lobby.conn[fd] then
        sql_cmd.on_line_false(lobby.data_base, lobby.conn[fd])
        sql_cmd.update_score(lobby.data_base, lobby.conn[fd], lobby.user_data[lobby.conn[fd]].score)
        lobby.conn[fd] = nil
    end
    socket.close(fd)
    Log.echo(addr, fd, "Lobby is waitting for reconnect")
end

function call.battle_end(args)
    lobby.user_data[args.account].battle = nil
    local res = args.res
    -- 更新比赛结果
end

return call