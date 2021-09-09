Config = {}

Config['Distance'] = 2.0

Config['Icon'] = 'fas fa-map-marked-alt'

Config['Main'] = {
    {
        ['Label'] = 'Teleport 1',
        ['Model'] = 'a_m_m_eastsa_02',
        ['Coords'] = vec3(205.0, -852.5, 29.6),
        ['Heading'] = 340.0,
        ['ZCoords'] = { ['min'] = 28.6, ['max'] = 31.6 },
    },
    {
        ['Label'] = 'Teleport 2',
        ['Model'] = 'a_m_m_socenlat_01',
        ['Coords'] = vec3(433.6, -985.7, 29.7),
        ['Heading'] = 90.0,
        ['ZCoords'] = { ['min'] = 28.7, ['max'] = 31.7 },
    }
}

Config['Zones'] = {
    { ['Label'] = 'Zones Available', ['Desc'] = '' },
    { ['Label'] = 'Police Station', ['Desc'] = '', ['Coords'] = vec3(423.3, -979.4, 30.7) },
    { ['Label'] = 'Plaza', ['Desc'] = '', ['Coords'] = vec3(204.8, -849.3, 30.6) }
}
