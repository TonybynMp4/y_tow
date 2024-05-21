fx_version 'cerulean'
game 'gta5'

author 'Tonybyn_Mp4'
description 'Towing resource for the Qbox framework'
repository 'https://github.com/TonybynMp4/y_tow'
version '1.0.0'

ox_lib 'locale'
shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua'
}

files {
    'config/client.lua',
    'config/shared.lua',
    'locales/*.json',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'ox_lib',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'