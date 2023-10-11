import {
  createRouter,
  createWebHistory,
  type RouteRecordRaw,
} from "vue-router";
import { useAuth } from "../stores/auth";

const Home = () => import("../pages/Home/Home.vue");
const SignIn = () => import("../pages/SignIn/SignIn.vue");
const SignUp = () => import("../pages/SignUp/SignUp.vue");
const Mentor = () => import("../pages/Mentor/Mentor.vue");
const Appointment = () => import("../pages/Appointment/Appointment.vue");
const UserInformation = () =>
  import("../pages/UserInformation/UserInformation.vue");

const constantRoutes: RouteRecordRaw[] = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/sign-in",
    name: "SignIn",
    component: SignIn,
  },
  {
    path: "/sign-up",
    name: "SignUp",
    component: SignUp,
  },
  {
    path: "/mentors",
    name: "Mentor",
    component: Mentor,
  },
  {
    path: "/appointments",
    name: "Appointment",
    component: Appointment,
    meta: { requiresAuth: true },
  },
  {
    path: "/user/:id",
    name: "UserInformation",
    component: UserInformation,
    meta: { requiresAuth: true },
    props: true,
  },

  // {
  //   path: "/404",
  //   component: () => import("../views/error-page/404.vue"),
  //   meta: {
  //     hidden: true,
  //   },
  //   alias: "/:pathMatch(.*)*",
  // },
  {
    path: "/:pathMatch(.*)*",
    redirect: "/404",
    name: "ErrorPage",
    meta: {
      hidden: true,
    },
  },
];

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: constantRoutes,
});

router.beforeEach((to, from, next) => {
  const auth = useAuth();
  if (to.meta.requiresAuth && !auth.isLoggedIn()) next({ name: "SignIn" });
  else next();
});

export default router;
