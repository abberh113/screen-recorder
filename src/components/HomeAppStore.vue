<template>
  <div class="container mt-5">
 <div class = row>
<div class = "col-md-2">
  <div class ="card">
  <div class = "card-header">
    <button @click="showTables" class ="btn btn-success btn-sm">
      <i class = "fa fa-video"> My Recordings</i></button>  
  </div>
  <div class = "card-body">
    <i class = "fa fa-share-alt"></i> Requested
  </div>
  </div>
</div>
<div class = col-md-10>
    <div class="card">
      <div class="card-header d-flex justify-content-between">
        <h6>My Recordings 25</h6>
  <button v-if="!recording" class="btn-sm btn btn-outline-secondary"><i class="fa fa-calendar-alt"></i> By Date</button>
  <button v-if="!recording" class="btn-sm btn btn-outline-secondary"><i class="fa fa-filter"></i> Add Filter<i class = "fa fa-caret-down"></i></button>
  <button v-if="!recording" class="btn-sm btn btn-primary"><i class="fa fa-video"></i> New Requested</button>
  <button @click="showRecordingOptions" :disabled="recording" v-if="!recording" class="btn-sm btn btn-danger"><i class="fa fa-play-circle"></i> Start Recording</button>
  <button @click="stopRecording" :disabled="!recording" class="btn-sm btn btn-danger" v-if="recording"><i class="fa fa-stop-circle"></i> Stop Recording</button>
  <button @click="downloadVideo" :disabled="!videoAvailable" class="btn-sm btn btn-success" v-if="!recording && videoAvailable"><i class="fa fa-download"></i> Download Video</button>
</div>

      <div class="card-body">
        <div class="row">
          <div class="col-md-12">
            <table class="table table-striped table-hover" v-if="showTable">
      <thead>
        <tr>
          <th>Recordings</th>
          <th>Title</th>
          <th>Views</th>
          <th>Size</th>
          <th>Last Modified</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="item in tableData" :key="item.id">
          <td>
            <video :src="getVideoUrl(item.id)" width="320" height="240" controls></video>
          </td>
          <td>{{ item.title }}</td>
          <td>{{ item.views }}</td>
          <td>{{ item.size }}</td>
          <td>{{ item.last }}</td>
        </tr>
      </tbody>
    </table>


            <video ref="video" width="640" height="480" controls v-if="!showTable"></video><br>
            <button v-if="!recording" class="btn-sm btn btn-primary mb-2"><i class = "fa fa-video"></i> New Requested</button>
        <button @click="showRecordingOptions" :disabled="recording" v-if="!recording" class="btn-sm btn btn-danger ms-2 mb-2"><i class = "fa fa-play-circle"></i> Start Recording</button>
          <hr>
         <h6><img src="adilo.jpeg"> Want more controls and better quality recording? <button class ="btn-sm btn btn-primary">Download the desktop recorder</button>
         </h6>
          </div>
        </div>
      </div>
    </div>

    <!-- Custom Modal for Recording Options -->
    <div v-if="showModal" class="modal">
      <div class="modal-content">
        <button @click="hideRecordingOptions" class="close-btn">&times;</button>
        <h2>Recording Options</h2>

        <!-- Switches for Recording Options -->
        <div class="record-options">
          <label>
            Record Screen:
            <input type="checkbox" v-model="recordScreen" />
          </label>
          <label>
            Record Microphone:
            <input type="checkbox" v-model="recordMic" />
          </label>
          <label>
            Record Camera:
            <input type="checkbox" v-model="recordCamera" />
          </label>
        </div>

        <!-- Buttons for Starting Recording -->
        <div>
          <button @click="startRecording" class="btn-sm btn btn-primary">Start Recording</button>
          <button @click="hideRecordingOptions" class="btn-sm btn btn-secondary">Cancel</button>
        </div>
      </div>
    </div>

    <!-- Loading Indicator -->
    <div v-if="loading" class="loading-indicator">
      Loading...
    </div>

    <!-- Display Recorded Videos -->
    <div class="recorded-videos">
      <h2>Recorded Videos</h2>
      <div v-for="recording in recordings" :key="recording.id" class="recorded-video">
        <video :src="recording.url" width="320" height="240" controls></video>
      </div>
    </div>
  </div>
  </div>
  </div>
</template>

<script>
import RecordRTC from 'recordrtc';
import download from 'downloadjs';

export default {
  data() {
    return {
      showTable : false,
      recording: false,
      videoAvailable: false,
      recorder: null,
      showModal: false,
      recordScreen: true,
      recordMic: true,
      recordCamera: true,
      loading: false,
      recordings: [], // Mocked backend data
      tableData: [
        { id: 1, title: 'Getting it right the first time', views: '500', size: '1024kb', last: '5 days ago' },
        { id: 2, title: 'Another video', views: '800', size: '2048kb', last: '3 days ago' },
        // Add more rows as needed
      ],
    };
  },
  methods: {

    showTables() {
    console.log('showTables method called');
    this.showTable = !this.showTable;
    console.log('showTable value:', this.showTable);
  },
    getVideoUrl(id) {
      // Assuming videos are in the public/videos folder
      return process.env.BASE_URL + 'public/screenrecording' + id + '.webm';
    },
    showRecordingOptions() {
      this.showModal = true;
    },
    hideRecordingOptions() {
      this.showModal = false;
    },
    async startRecording() {
      try {
        this.loading = true;

        // Request permissions based on selected options
        const constraints = {
          video: this.recordScreen,
          audio: this.recordMic ? { echoCancellation: true, noiseSuppression: true } : false,
        };
        const stream = await navigator.mediaDevices.getDisplayMedia(constraints);

        // Set the video source object
        this.$refs.video.srcObject = stream;

        // Programmatically play the video to start recording
        this.$refs.video.play();

        // Start recording
        this.recorder = new RecordRTC(stream, { type: 'video' });
        this.recording = true;
        this.recorder.startRecording();

        this.hideRecordingOptions();

        // Simulate backend response with recording details
        const recordingDetails = {
          id: Date.now(), // Use a unique identifier
          url: '', // You might want to set this when the recording is available
          type: 'video',
          // ... other details you want to include
        };

        // Mocked backend response
        this.recordings.push(recordingDetails);
      } catch (error) {
        console.error('Error starting recording:', error);
        // Handle permission denied or other errors
      } finally {
        this.loading = false;
      }
    },
    stopRecording() {
      this.recording = false;
      this.recorder.stopRecording(() => {
        this.$refs.video.src = this.recorder.toURL();
        this.videoAvailable = true;
      });
    },
    downloadVideo() {
      const blob = this.recorder.getBlob();
      download(blob, 'screenRecording.webm', 'video/webm');
    },
  },
};
</script>

<style scoped>
/* Add your styles here if needed */

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
}

.modal-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
  max-width: 400px;
}

.close-btn {
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  position: absolute;
  top: 10px;
  right: 10px;
}

.record-options {
  margin-bottom: 15px;
}

.record-options label {
  display: block;
  margin-bottom: 5px;
}

.loading-indicator {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(255, 255, 255, 0.8);
  padding: 20px;
  border-radius: 8px;
}

.recorded-videos {
  margin-top: 20px;
}

.recorded-video {
  margin-bottom: 10px;
}
</style>
