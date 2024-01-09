<template>
  <div id="app">
    <Navbar />
    <HomeAppStore />
  </div>
</template>

<script>
import Navbar from './components/Navbar.vue';
import HomeAppStore from './components/HomeAppStore.vue';  // Updated import

export default {
  name: 'App',
  components: {
    Navbar,
    HomeAppStore,  // Updated usage
  },
};
</script>

<style>
/* Add your custom styles here */
</style>
