Config = {}

Config['Locale'] = 'en'

Config['KeyPressed'] = 38 -- E

Config['Distance'] = 1.5

Config['Cooldown'] = 1000 -- miliseconds

Config['Settings'] = {
    {
        model = 'a_m_m_socenlat_01',
        anim = 'WORLD_HUMAN_AA_SMOKE',
        coords = { x = 214.56092834473, y = -812.6318359375, z = 30.705089569092, h = 160.39071655273 } 
    },
    {
        model = 'a_m_m_golfer_01',
        anim = 'WORLD_HUMAN_AA_SMOKE',
        coords = { x = 433.65176391602, y = -985.73608398438, z = 30.710428237915, h = 89.06812286377 } 
    }
}

Config['Points'] = {
    { id = 0, label = 'Locations Available', txt = '' },
    { id = 1, label = 'Garage', txt = 'Central Garage', coords = { x = 212.88935852051, y = -816.54449462891, z = 30.711214065552 }},
    { id = 2, label = 'Police Station', txt = 'Mission Row Police Station', coords = { x = 427.05944824219, y = -978.97210693359, z = 30.710809707642 }},
}

Config['Locales'] = {
    ['es'] = {
        Text = '~b~[E]~s~ | Teletransporte',
        Notify = 'Fuiste enviado a ',
    },

    ['en'] = {
        Text = '~b~[E]~s~ | Teleport',
        Notify = 'You were sent to ',
    }
}
