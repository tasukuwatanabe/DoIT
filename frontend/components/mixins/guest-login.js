import axios from 'axios';
import { mapActions } from 'vuex';

export default {
  methods: {
    ...mapActions({
      setCurrentUserAction: 'user/setCurrentUserAction',
    }),
    async guestLogin() {
      await axios
        .post('/api/guest_login')
        .then((res) => {
          this.$router.push({ name: 'todos' });
          this.flashMessage.success({
            title: res.data.message,
            time: 5000,
            icon: 'assets/images/icons/success.svg',
          });
        })
        .catch((error) => {
          this.flashMessage.error({
            title: error.response.data.message,
            icon: 'assets/images/icons/error.svg',
          });
        });
      await axios.get('/api/current_user').then((res) => {
        this.setCurrentUserAction(res.data);
      });
    },
  },
};