<template>
  <div class="page add-page">

    <!-- ÜST KART -->
    <div class="card card-style add-card">
      <div class="content">
        <span class="warning-text" v-if="numberOfMyPostsWithin24Hours > 0">
          {{ $t('add.warning3') }}: <span style="font-weight: 800;">{{3 - numberOfMyPostsWithin24Hours}}</span> {{ $t('add.warning3_2') }}
        </span>

        <!-- Publisher header -->
        <div class="publisher-header" v-if="currentPublisher">
          <ProfileAvatar class="publisher-header__avatar" :name="currentPublisher.name" :photo-url="headerAvatarUrl()"
            size="52" :clickable="true" @click="handleHeaderClick" />
          <div class="publisher-header__meta" @click="handleHeaderClick">
            <div class="publisher-header__name">{{ currentPublisher.name }}</div>
            <div class="publisher-header__hint">
              {{
                currentPublisher.type === 'business'
                  ? $t('add.publisher.business')
                  : $t('add.publisher.user')
              }}
            </div>
          </div>
        </div>

        <!-- Publisher switcher -->
        <div class="publisher-switcher" v-if="publisherOptions.length > 1">
          <button v-for="opt in publisherOptions" :key="opt.type + '-' + opt.id" class="publisher-pill"
            :class="{ active: isPublisherActive(opt) }" @click="selectPublisher(opt)" type="button">
            <ProfileAvatar :name="opt.name" :photo-url="publisherAvatarUrl(opt)" size="38" />
          </button>
        </div>

        <!-- Category picker -->
        <div class="category-picker">
          <div class="category-picker__title">{{ $t('add.category.title') }}</div>
          <el-radio-group v-model="selectedCategory" size="small" class="category-group">
            <el-radio-button v-for="c in categoryOptions" :key="c.value" :label="c.value">
              <i :class="c.icon" class="cat-ico"></i>
              <span>{{ c.label }}</span>
            </el-radio-button>
          </el-radio-group>
        </div>

        <!-- Text -->
        <div class="text-wrap">
          <textarea class="add-input" v-model="description" :placeholder="placeholderText" />
        </div>

        <!-- Event fields (only when category = Etkinlik) -->
        <div v-if="isEventCategory" class="event-fields">
          <div class="event-fields__row">
            <div class="event-fields__col">
              <div class="event-fields__label">{{ $t('add.event.dayFrom') }}</div>
              <input class="event-fields__input" type="date" v-model="eventForm.from_date">
            </div>

            <div class="event-fields__col">
              <div class="event-fields__label">{{ $t('add.event.dayTo') }}</div>
              <input class="event-fields__input" type="date" v-model="eventForm.until_date">
            </div>
          </div>

          <div class="event-fields__row">
            <div class="event-fields__col">
              <div class="event-fields__label">{{ $t('add.event.timeFrom') }}</div>
              <input class="event-fields__input" type="time" v-model="eventForm.start_time">
            </div>

            <div class="event-fields__col">
              <div class="event-fields__label">{{ $t('add.event.timeTo') }}</div>
              <input class="event-fields__input" type="time" v-model="eventForm.end_time">
            </div>
          </div>

          <div class="event-fields__row">
            <div class="event-fields__col event-fields__col--full">
              <div class="event-fields__label">{{ $t('add.event.location') }}</div>
              <input class="event-fields__input" type="text" v-model="eventForm.location"
                :placeholder="$t('add.event.locationPlaceholder')">
            </div>
          </div>
        </div>

        <!-- Poll -->
        <template v-if="questionnaire">
          <div class="poll-wrap">
            <div class="option row m-0" v-for="(option, index) in options" :key="option.id">
              <div class="col-10 m-1">
                <input class="form-control" v-model="option.name" :placeholder="option.placeholder" />
              </div>
              <div class="col-1 poll-remove" v-if="options.length > 2" @click="removeOption(index)">
                <i class="fa fa-times"></i>
              </div>
            </div>

            <div class="option row m-0">
              <div class="col-12" @click="addOption">
                <div class="add-option">{{ addOptionText }}</div>
              </div>
            </div>
          </div>
        </template>

      </div>
    </div>

    <!-- UPLOAD KARTI -->
    <div class="card card-style add-card mt-3">
      <div class="content">
        <div class="media-row">

          <!-- FOTO -->
          <div class="media-item">
            <div class="media-item__title">
              <i class="fas fa-camera-retro"></i>
              {{ $t('add.media.photo.title') }}
            </div>

            <div class="media-tile">
              <el-upload class="post-media-upload post-media-upload--photo" list-type="text" accept="image/*"
                :limit="10" :auto-upload="true" :before-upload="beforePhotoUpload" :http-request="uploadPhotoRequest"
                @remove="onRemovePhoto">
                <div class="tile-cta">
                  <i class="fas fa-plus"></i>
                  <span>{{ addPhotoText }}</span>
                </div>
              </el-upload>
            </div>
          </div>

          <!-- VİDEO -->
          <div class="media-item">
            <div class="media-item__title">
              <i class="fas fa-video"></i>
              {{ $t('add.media.video.title') }}
            </div>

            <div class="media-tile">
              <el-upload class="post-media-upload post-media-upload--video" list-type="text" accept="video/*"
                :limit="10" :auto-upload="true" :before-upload="beforeVideoUpload" :http-request="uploadVideoRequest"
                @remove="onRemoveVideo">
                <div class="tile-cta">
                  <i class="fas fa-plus"></i>
                  <span>{{ addVideoText }}</span>
                </div>
              </el-upload>
            </div>
          </div>

          <!-- ANKET -->
          <div class="media-item">
            <div class="media-item__title">
              <i class="fas fa-question"></i>
              {{ $t('add.media.poll.title') }}
            </div>

            <div class="media-tile" @click="toggleQuestionnaire">
              <div class="post-media-upload post-media-upload--video">
                <div class="el-upload el-upload--text" tabindex="0" aria-disabled="false" role="button">
                  <div class="tile-cta">
                    <i class="fas fa-plus"></i>
                    <span>{{ questionnaire ? closeQuestionnaireText : addQuestionnaireText }}</span>
                  </div>
                </div>
                <ul class="el-upload-list el-upload-list--text"></ul>
              </div>
            </div>
          </div>

          <div class="media-preview" v-if="photos.length">
            <img v-for="(u, i) in photos" :key="u + i" :src="makeAbsolute(u)" class="preview-img" />
          </div>

          <div class="media-preview" v-if="videos.length">
            <video v-for="(u, i) in videos" :key="u + i" controls class="preview-video">
              <source :src="makeAbsolute(u)" type="video/mp4" />
            </video>
          </div>

        </div>
      </div>
    </div>

    <!-- SEND -->
    <div class="card card-style add-card mt-3 mb-5">
      <div class="content">
        <button class="btn btn-full btn-m send-btn" @click="sendPost" :disabled="isSending">
          {{ sendText }}
        </button>
        <div v-if="sendError" class="send-error">{{ $t('add.errors.generic') }}</div>
      </div>
    </div>

  </div>
</template>

<script src="./add.js"></script>
<style src="./add.css" scoped></style>