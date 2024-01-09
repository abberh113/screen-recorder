<template>
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
      <router-link to="/" class="navbar-brand">Screen Recorder</router-link>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <router-link to="/" class="nav-link" exact>Projects</router-link>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Tools & App
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Snapbyte Recorder</a></li>
              <li><a class="dropdown-item" href="#">Audio Bounce</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">Sugar Voice</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <router-link to="/channels" class="nav-link">Channels</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/contacts" class="nav-link">Contacts</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/analytics" class="nav-link">Analytics</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/settings" class="nav-link">Settings</router-link>
          </li>
          <li class="nav-item">
            <router-link to="/help" class="nav-link">Help</router-link>
          </li>
        </ul>
        <form class="d-flex" role="search">
          <button class="btn btn-outline-success" type="button">Recorder</button>
        </form>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'AppNavbar',
};
</script>

<style scoped>
/* Add your custom styles here if needed */
</style>
