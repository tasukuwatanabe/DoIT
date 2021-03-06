<template>
  <section class="sidebar-shortcut">
    <div class="sidebar-shortcut__box">
      <div class="sidebar-shortcut__title">ショートカットからToDo作成</div>
      <router-link
        to="/shortcuts"
        v-if="shortcuts"
        class="sidebar-shortcut__edit"
      >
        編集
      </router-link>
    </div>
    <div class="sidebar-shortcut__field" 
        :class="{ 'sidebar-shortcut__field--center' : !this.getShortcuts.length }">
      <ul v-if="this.getShortcuts.length" class="sidebar-shortcut__list">
        <li
          v-for="shortcut in this.getShortcuts"
          :key="shortcut.id"
          class="sidebar-shortcut__item"
        >
          <a @click="createTodo(shortcut)" class="sidebar-shortcut__link">
            <i class="fas fa-plus-circle"></i>
            {{ shortcut.title }}
          </a>
        </li>
      </ul>
      <div v-else class="sidebar-shortcut__no-result">
        <p class="sidebar-shortcut__text">ショートカットが未作成です</p>
        <div class="page-action">
          <router-link to="/shortcuts" class="btn">
            <span class="page-action__icon">
              <i class="fas fa-plus"></i>
            </span>
            <span class="page-action__text">ショートカットを追加</span>
          </router-link>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { axiosForBackend } from "../../config/axios";
import { mapGetters, mapActions } from "vuex";
import Logout from "../mixins/logout";

export default {
  data() {
    return {
      shortcuts: []
    };
  },
  mixins: [Logout],
  computed: {
    ...mapGetters({
      getShortcuts: "shortcut/getShortcuts",
      getSelectedDate: "date/getSelectedDate",
    })
  },
  methods: {
    ...mapActions({
      setSelectedDateAction: "date/setSelectedDateAction"
    }),
    createTodo(shortcut) {
      const label_arr = [];
      label_arr.push(shortcut.label_id);
      axiosForBackend.post("/todos", {
        todo: {
          title: shortcut.title,
          todo_date: this.getSelectedDate,
          label_ids: label_arr
        }
      }).then(() => {
        this.setSelectedDateAction(this.getSelectedDate);
      });
    }
  }
};
</script>

<style lang="scss" scoped>
@import "../../stylesheets/variables.scss";
@import "../../stylesheets/extend.scss";

.sidebar-shortcut {
  @media (max-width: 991px) {
    margin-bottom: 30px;
  }

  &__field {
    padding: 10px;
    background-color: #fff;
    text-align: center;
    box-shadow: $box-shadow-common;
    min-height: 250px;

    &--center {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    @media (max-width: 991px) {
      padding: 10px;
    }
  }

  &__box {
    display: flex;
    justify-content: space-between;
    margin-bottom: 7px;
  }

  &__title {
    font-size: .85em;
    font-weight: bold;

    @media (max-width: 991px) {
      font-size: 1em;
    }
  }

  &__edit {
    text-decoration: underline;
    color: $color-main-theme;
    font-size: 0.9em;
  }

  &__list {
    list-style-type: none;
    display: flex;
    flex-wrap: wrap;
    padding: 0;
    margin: 0;
  }

  &__item {
    background-color: #fff;
    border-radius: 100px;
    margin: 5px;
    font-size: 0.9em;

    @media (max-width: 991px) {
      margin: 6px;
    }
  }

  &__link {
    @extend %link;
    color: $color-base-font;
    padding: 3px 8px;
    border-radius: 3px;
    display: block;
    background-color: #eee;

    svg {
      color: #999;
    }
  }

  &__text {
    margin-bottom: 20px;
    font-size: 0.9em;
  }

  .page-action {
    border: 1px solid $color-main-theme;
    background-color: #fff;
    border-radius: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    transition-duration: 0.2s;
    padding: 4px 15px;
    a {
      font-size: 0.9em !important;
      color: $color-main-theme !important;
      &:hover {
        opacity: .8;
      }
    }
  }
}
</style>