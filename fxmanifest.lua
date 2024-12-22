fx_version 'cerulean'
game 'gta5'

name 'S-DrugCrafting'
description 'Custom drug crafting and selling script for QBCore'
author 'Strg'
version '1.0.0'

dependency 'qb-core'
dependency 'qb-menu'

-- Shared configuration and utility functions
shared_script 'config.lua'

-- Server logic
server_script 'server/server.lua'

-- Client logic
client_script 'client/client.lua'