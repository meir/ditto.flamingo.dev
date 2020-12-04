<svelte:head>
    <title>ditto conga</title>
</svelte:head>

<script>

import Renderer from '../components/renderer.svelte'
import Audio from '../components/audio.svelte'

const colors = [
    '#a144dc',
    '#2bd0e5',
    '#7d0169',
    '#5ff12a',
    '#cdb82c',
    '#83afa9',
    '#9ec603',
    '#1746ba'
]

$: color_a = '#000'
$: color_b = '#fff'

$: style = `--color-a: ${ color_a }; --color-b: ${ color_b };`

function colorChange() {
    let index_a = Math.floor(Math.random() * colors.length)
    let index_b = Math.floor(Math.random() * colors.length)
    color_a = colors[index_a]
    if(index_a == index_b) {
        index_b++
        if(index_b == colors.length) index_b = 0
    }
    color_b = colors[index_b]
}

let started = false

function start() {
    started = true
}

</script>


{#if started}
    <Audio />
    <div style={style}>
        <Renderer background={ colorChange } />
        <div id="outer">
            <div id="inner">
                <img src="/ditto.gif" alt="shiny ditto">
            </div>
        </div>
    </div>
{:else}
    <button on:click={start}>Click to Conga!</button>
{/if}

<style>

button {
    width: 100%;
    height: 100%;
    background-color: black;
    color: white;
    border: 0;
    outline: none;
    cursor: pointer;
    font-size: 50px;
}

div:not([id]) {
    position: relative;
    overflow: hidden;
    height: 100%;
    display: flex;
    flex-flow: column;
}

div {
    overflow: hidden;
}

#outer {
    flex-grow : 1;
    background-color: var(--color-a);
    padding: 40px;
    display: flex;
    flex-flow: column;
}

#inner {
    background-color: var(--color-b);
    border-radius: 10px;
    flex-grow : 1;
    display: flex;
}

img {
    margin: auto auto;
}

</style>