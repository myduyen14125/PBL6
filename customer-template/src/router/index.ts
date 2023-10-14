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
const Blog = () => import("../pages/Blog/Blog.vue");
const BlogInformation = () => import("../pages/Blog/_id/index.vue");
const PersonalInformation = () =>
  import("../pages/PersonalInformation/PersonalInformation.vue");

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
    path: "/blogs",
    name: "Blog",
    component: Blog,
  },
  {
    path: "/blogs/:id",
    name: "BlogInformation",
    component: BlogInformation,
    props: true,
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
    props: true,
  },
  {
    path: "/personal-info",
    name: "PersonalInformation",
    component: PersonalInformation,
    meta: { requiresAuth: true },
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
  window.scrollTo(0, 0);
  const auth = useAuth();
  if (to.meta.requiresAuth && !auth.isLoggedIn()) next({ name: "SignIn" });
  else next();
});

export default router;
