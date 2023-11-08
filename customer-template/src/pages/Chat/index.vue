<template>
  <GuestLayout>
    <div class="chat-wrapper">
      <div class="container py-14 text-lg">
        <vue-advanced-chat
          height="80vh"
          :current-user-id="currentUserId"
          :rooms="JSON.stringify(rooms)"
          :rooms-loaded="true"
          :messages="JSON.stringify(messages)"
          :messages-loaded="messagesLoaded"
          @send-message="sendMessage($event.detail[0])"
          @fetch-messages="fetchMessages($event.detail[0])"
        />
      </div>
    </div>
  </GuestLayout>
</template>

<script>
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import { register } from 'vue-advanced-chat'
import { useUser } from "../../stores/user";
import SwalPopup from "../../ultils/swalPopup";
import Swal from "sweetalert2";

register()

export default {
  components: { GuestLayout, SvgIcon },
  props: {
    id: {
      type: String,
      required: false, // todo: set true, false để test
    },
  },
  data() {
		return {
      user: {},
			currentUserId: '1234',
			rooms: [
				{
					roomId: '1',
					roomName: 'Room 1',
					avatar: 'https://66.media.tumblr.com/avatar_c6a8eae4303e_512.pnj',
					users: [
						{ _id: '1234', username: 'Yuu nè' },
						{ _id: '4321', username: 'John Snow' }
					]
				},
        {
          roomId: '2',
          roomName: 'Room 2',
          avatar: 'https://66.media.tumblr.com/avatar_c6a8eae4303e_512.pnj',
          users: [
            { _id: '1234', username: 'Yuu nè' },
            { _id: '4321', username: 'John Snow' }
          ]
        }
			],
			messages: [],
			messagesLoaded: false
		}
	},
  methods: {
		fetchMessages({ options = {} }) {
			setTimeout(() => {
				if (options.reset) {
					this.messages = this.addMessages(true)
				} else {
					this.messages = [...this.addMessages(), ...this.messages]
					this.messagesLoaded = true
				}
				// this.addNewMessage()
			})
		},

		addMessages(reset) {
			const messages = []

			for (let i = 0; i < 30; i++) {
				messages.push({
					_id: reset ? i : this.messages.length + i,
					content: `${reset ? '' : 'paginated'} message ${i + 1}`,
					senderId: '4321',
					username: 'Yuu nè',
					date: '13 November',
					timestamp: '10:20'
				})
			}

			return messages
		},

		sendMessage(message) {
			this.messages = [
				...this.messages,
				{
					_id: this.messages.length,
					content: message.content,
					senderId: this.currentUserId,
					timestamp: new Date().toString().substring(16, 21),
					date: new Date().toDateString()
				}
			]
		},

		addNewMessage() {
			setTimeout(() => {
				this.messages = [
					...this.messages,
					{
						_id: this.messages.length,
						content: 'NEW MESSAGE',
						senderId: '1234',
						timestamp: new Date().toString().substring(16, 21),
						date: new Date().toDateString()
					}
				]
			}, 2000)
		},

    getUserInformation: function () {
      const userStore = useUser();
      userStore.requestGetUserSchedules({
        id: this.id,
        callback: {
          onSuccess: (res) => {
            this.user = res;
            console.log(this.user);
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    },

    setUserInfo: function () {
      this.currentUserId = this.user._id;
      this.rooms[0].users[0]._id = this.user._id;
      this.rooms[0].users[0].username = this.user.name;
    }
	},
  async mounted() {
    // await this.getUserInformation();
    // this.setUserInfo();
  },
}
</script>
<style scoped lang="css">
</style>