<script setup lang="ts">
import { ref } from 'vue'

const containerName = ref("")
const apiKey = ref("")

const state = ref<"idle" | "provisioning" | "error" | "success">("idle")

async function submit() {
  await fetch("/api/createContainer", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      containerName: containerName.value,
      apiKey: apiKey.value
    })
  })

  state.value = "provisioning"

  while (true) {
    const response = await fetch("api/getContainerStatus?containerName=" + containerName.value)
    const data = await response.json()
    if (data.status === "error") {
      state.value = "error"
      break
    } else if (data.status === "success") {
      state.value = "success"
      break
    }
    await new Promise(resolve => setTimeout(resolve, 5000))
  }
}
</script>

<template>
  <section id="center">
    <input v-model="containerName" placeholder="Container Name" />
    <input v-model="apiKey" placeholder="API Key" />
    <button type="button" class="counter" @click="submit">
      Submit
    </button>
    <p>{{ state }}</p>
  </section>
</template>
