<svelte:head>
    <title>ditto conga</title>
</svelte:head>

<script>

import { onMount } from 'svelte'

export let background = () => {}

const SECOND = 1000
const STRAFE_FPS = 60
const STRAFE_DELTA = SECOND / STRAFE_FPS
const COLOR_CHANGE_TIME = SECOND * .6

const timers = {}

let looping = true

onMount(() => {
    timers[STRAFE_DELTA] = {method: tick}
    timers[COLOR_CHANGE_TIME] = {method: background}
    loop(0)
})

function loop(delta) {
    if(!looping) return

    const keys = Object.keys(timers)
    keys.forEach((key) => {
        const value = timers[key]
        if(!value.last_time) value.last_time = 0
        if((delta - value.last_time) > key) {
            value.last_time = delta
            value.method(delta)
        }
    })

    requestAnimationFrame(loop)
}

$: dittos = []

function tick(delta) {
    if(Math.random() < (.1 - (dittos.length/100))) {
        dittos.push({
            delta: 0,
            speed: (Math.random() * .3) + .7,
            direction: Math.random() > .5,
            size: Math.floor(Math.random() * 120) + 120,
            height: Math.floor(Math.random() * 95)
        })
    }
    for(let i = dittos.length - 1; i >= 0; i--) {
        dittos[i].delta++
        const pos = dittos[i].delta * STRAFE_DELTA * dittos[i].speed
        if(dittos[i].direction) {
            if((window.innerWidth + dittos[i].size) - pos < -dittos[i].size) dittos.splice(i, 1)
        }else{
            if(-dittos[i].size + pos > window.innerWidth + dittos[i].size) dittos.splice(i, 1)
        }
    }
    dittos = dittos
}

window.STOP = () => {
    looping = false
}

</script>

{#each dittos as ditto}
    <img src="/ditto.gif" alt="ditto" style={`
        position: absolute;
        opacity: .5;
        overflow: hidden;
        width: ${ditto.size}px;
        top: ${ditto.height}%;
        left: ${(() => {
            const pos = ditto.delta * STRAFE_DELTA * ditto.speed
            if(ditto.direction) {
                return (window.innerWidth + ditto.size) - pos
            }else{
                return -ditto.size + pos
            }
        })()}px;
    `}>
{/each}

<style>

img {
    margin: auto auto;
}

</style>