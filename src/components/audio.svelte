<script>

import { onMount } from 'svelte'

let hidden = false
let audio = null
let volume = 30

onMount(() => {
    audio.volume = volume/100
})

function setvolume() {
    audio.volume = volume/100
}

</script>

<span>
    volume: 
    <input type="range" min="1" max="100" bind:value={volume} on:input={setvolume}>
</span>

<audio bind:this={audio} autoplay loop volume=".3">
    <source src="/Conga.mp3" type="audio/mpeg">
</audio>

<style>
    span {
        position: absolute;
        top: 0;
        left: 0;
        z-index: 999;
    }
</style>