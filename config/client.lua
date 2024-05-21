return {
    towVehicleModels = {
        `flatbed`,
        `trailerflat2`,
        `trflat`,
        `wastelander`,
        `slamtruck`,
        `skylift`
    },
    offsets = {
        bone = {
            [`flatbed`] = 'transmission_r',
            [`trailerflat2`] = 'attach_male',
            [`trflat`] = 'attach_male',
            [`wastelander`] = 'engine',
            [`slamtruck`] = 'engine',
            [`skylift`] = "engine"
        },
        tow = {
            coords = {
                [`flatbed`] = vec3(0, -1.5, 0.5),
                [`trailerflat2`] = vec3(0.1, -4.25, 0.9),
                [`trflat`] = vec3(0, -5, 0.5),
                [`wastelander`] = vec3(0.0, -3, 0.55),
                [`slamtruck`] = vec3(0.0, -4.5, 0.35),
                [`skylift`] = vec3(0.0, 1.5, -3.5)
            },
            rot = {
                -- [`flatbed`] = vec3(0.0, 0.0, 0.0) -- Optional
                [`slamtruck`] = vec3(5.0, 0.0, 0.0)
            }
        },
        drop = {
            coords = {
                [`flatbed`] = vec3(0.0, -10.0, -1.0),
                [`trailerflat2`] = vec3(0.0, -6.5, 0.0),
                [`trflat`] = vec3(0.0, -6.5, 0.0),
                [`wastelander`] = vec3(0.0, -6.0, -1.0),
                [`slamtruck`] = vec3(0.0, -10.0, -1.0),
                [`skylift`] = vec3(0.0, -0.5, -2.5)
            },
            rot = {}
        }
    }
}