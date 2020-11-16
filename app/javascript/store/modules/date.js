const namespaced = true;

const state = {
  selectedDate: undefined
}

const getters = {
  selectedDate(state) {
    return state.selectedDate;
  },
  formatDate(state) {
    const year = state.selectedDate.getFullYear();
    const month = state.selectedDate.getMonth() + 1;
    const date = state.selectedDate.getDate();

    return `${year}-${month}-${date}`;
  },
}

const mutations = {
  setSelectedDate(state, date) {
    state.selectedDate = date;
  }
}

const actions = {
  setSelectedDateAction({ commit, state }, set_date) {
    let selected_date;
    if (set_date) {
      selected_date = new Date(set_date);
    } else if (state.selectedDate) {
      selected_date = new Date(state.selectedDate);
    } else {
      selected_date = new Date();
    }
    commit("setSelectedDate", selected_date);
  },
}

export default {
  namespaced,
  state,
  mutations,
  actions,
  getters
}