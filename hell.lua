---@type discordia
local dia = require("discordia")
local dcmd = require("discordia-commands")
local autocomplete = require("autocomplete")
local commandType = dia.enums.appCommandType
local optionType = dia.enums.appCommandOptionType
local client = dia.Client{
	logFile = 'mybot.log',
	cacheAllMembers = true,
}:useApplicationCommands()

dia.extensions()
local function initializeCommands1(guild)
local command, err = client:createGuildApplicationCommand(guild.id, {
    type = commandType.chatInput,
    name = "log",
    description = " nice",
})
end
local function initializeCommands2(guild)
local command, err = client:createGuildApplicationCommand(guild.id, {
    type = commandType.chatInput,
    name = "get-users",
    description = " nice",
    options = {
        {
            type = optionType.subCommand,
            name = " from",
            description = "Enter the id",
            options = {
                {
                    type = optionType.string,
                    name = "role",
                    description = "id",
                    required = true,
                    autocomplete = true,
                },
                
            },
        },
    },
})
end
local function initializeCommands(guild)
    local command, err = client:createGuildApplicationCommand(guild.id, {
        type = commandType.chatInput,
        name = "get-users-ping",
        description = ".",
        options = {
            {
                type = optionType.subCommand,
                name = "from",
                description = "input your id",
                options = {
                    {
                        type = optionType.string,
                        name = "role",
                        description = "id",
                        required = true,
                        autocomplete = true,
                    },
                    
                },
            },
        },
    })
    end

client:on("ready", function()
    for guild in client.guilds:iter() do
        initializeCommands(guild)
        initializeCommands2(guild)
        initializeCommands1(guild)
    end
end)
client:on("slashCommand", function(interaction, command, args)
    Base = ""
    if interaction.data.name == "log" then
        for member in interaction.member.voiceChannel.connectedMembers:iter() do        
       local Member = Base        
       Base = Member.."\n"..member.name
    end
    interaction:reply(Base)
    end
    BG = ""
    Beau = ""
    if interaction.data.name == "get-users" then
      for member in interaction.guild.members:iter() do
        if member:hasRole(args.from.role) then
          BG = BG.."\n"..member.name
        end
       end
       print(BG)
        interaction:reply(BG)
       if err then interaction:reply(err) end
      end
      if interaction.data.name == "get-users-ping" then
        for member in interaction.guild.members:iter() do
            if member:hasRole(args.from.role) then
              Beau = Beau.."\n".."<@"..member.id..">"
            end
           end
           local success, err = interaction:reply(Beau)
           if err then print(err) end
end
end)
    
client:run("Bot OTMwMjc5OTcxOTgzODgwMjAz.GkInEc.Rzfars1kCTxJTWxkdCzancdYoM_E6dUA2t6emc")
