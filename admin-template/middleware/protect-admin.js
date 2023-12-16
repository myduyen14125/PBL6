export default function ({ $auth, route, redirect }) {
  // const isLoggedIn = $auth.loggedIn;
  // console.log($auth);
  const hasAccessToken = sessionStorage.getItem("IT_MENTOR_accessToken");
  if (hasAccessToken && route.path === "/login") {
    return redirect("/mentor");
  }
  if (!hasAccessToken && route.path !== "/login") {
    return redirect("/login");
  }
}
