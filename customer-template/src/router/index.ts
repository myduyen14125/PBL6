import {
  createRouter,
  createWebHistory,
  type RouteRecordRaw,
} from "vue-router";
import { useAuth } from "../stores/auth";
import { getUserInfo } from "../ultils/cache/localStorage";

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
const CreateBlog = () => import("../pages/Blog/CreateBlog/CreateBlog.vue");
const BookAppointment = () => import("../pages/BookAppointment/index.vue");
const MyAppointment = () => import("../pages/MyAppointment/index.vue");
const MyBlog = () => import("../pages/MyBlog/MyBlog.vue");
const ChangePassword = () => import("../pages/ChangePassword/ChangePassword.vue");

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
    path: "/blogs/:id",
    name: "BlogInformation",
    component: BlogInformation,
    props: true,
  },
  {
    path: "/blogs",
    name: "Blog",
    component: Blog,
  },
  {
    path: "/create-blog",
    name: "CreateBlog",
    component: CreateBlog,
    meta: { requiresAuth: true, role: "mentor" },
  },
  {
    path: "/edit-blog/:id",
    name: "EditBlog",
    component: CreateBlog,
    meta: { requiresAuth: true, role: "mentor" },
    props: true,
  },
  {
    path: "/my-blogs",
    name: "MyBlog",
    component: MyBlog,
    meta: { requiresAuth: true, role: "mentor" },
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
  {
    path: "/book-appointment/:id",
    name: "BookAppointment",
    component: BookAppointment,
    props: true,
  },
  {
    path: "/my-appointments",
    name: "MyAppointment",
    component: MyAppointment,
    meta: { requiresAuth: true, role: "mentor" },
  },
  {
    path: "/change-password",
    name: "ChangePassword",
    component: ChangePassword,
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
  if (to.meta.role && getUserInfo()?.role != to.meta.role)
    next({ name: "ErrorPage" });
  else next();
});

export default router;
