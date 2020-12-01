import axios from 'axios';
import { mapActions } from 'vuex';

export default {
  methods: {
    ...mapActions({
      setCurrentUserAction: 'user/setCurrentUserAction',
    }),
    guestLogin() {
      const session_params = {
        email: 'guest@example.com',
      };
      axios
        .post('/api/login', { session: session_params })
        .then((res) => {
          this.setCurrentUserAction(res.data.user);
          this.$router.push({ name: 'todos' });
          this.flashMessage.success({
            title: res.data.message,
            time: 5000,
            icon: '/icons/success.svg',
          });
        })
        .catch((error) => {
          this.flashMessage.error({
            title: error.message,
            time: 5000,
            icon: '/icons/error.svg',
          });
        });
    },
  },
};
