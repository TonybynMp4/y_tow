return {
    restrictToGroups = false,
    towGroups = {
        "tow",
        "bennys"
    },

    attachTime = 7500,
    detachTime = 7500,

    towVehicleModels = {
        `flatbed`,
        `trailerflat2`,
        `trflat`,
        `wastelander`,
        `slamtruck`,
        `skylift`,
        `titan`,
        `bombushka`,
        `boattrailer`
    },
    --max allowed distance between vehicles to attach/detach
    maxDistanceFromTower = 15.0,
    offsets = {
        bone = {
            [`flatbed`] = 'transmission_r',
            [`trailerflat2`] = 'attach_male',
            [`trflat`] = 'attach_male',
            [`wastelander`] = 'engine',
            [`slamtruck`] = 'engine',
            [`skylift`] = 'engine',
            [`titan`] = 'chassis',
            [`bombushka`] = 'chassis',
            [`boattrailer`] = 'attach_male'
        },
        tow = {
            --offset from BONE
            coords = {
                [`flatbed`] = vec3(0, -1.5, 0.5),
                [`trailerflat2`] = vec3(0.1, -4.25, 0.9),
                [`trflat`] = vec3(0, -5, 0.75),
                [`wastelander`] = vec3(0.0, -3, 0.55),
                [`slamtruck`] = vec3(0.0, -4.5, 0.35),
                [`skylift`] = vec3(0.0, 1.5, -3.5),
                [`titan`] = vec3(0.0, -4.0, 0.15),
                [`bombushka`] = vec3(0.0, -5.0, 0.15),
                [`boattrailer`] = vec3(0.0, -5, 0.5)
            },
            rot = {
                -- [`flatbed`] = vec3(0.0, 0.0, 0.0) -- Optional
                [`slamtruck`] = vec3(5.0, 0.0, 0.0)
            }
        },
        drop = {
            --offset from BONE
            coords = {
                [`flatbed`] = vec3(0.0, -10.0, -1.0),
                [`trailerflat2`] = vec3(0.0, -10.0, 0.0),
                [`trflat`] = vec3(0.0, -20.0, 0.5),
                [`wastelander`] = vec3(0.0, -10.0, -1.0),
                [`slamtruck`] = vec3(0.0, -10.0, -1.0),
                [`skylift`] = vec3(0.0, -0.5, -2.5),
                [`titan`] = vec3(0.0, -15.0, -0.25),
                [`bombushka`] = vec3(0.0, -25.0, 0.0),
                [`boattrailer`] = vec3(0.0, -15.0, 1.0)
            },
            rot = {}
        }
    }
}