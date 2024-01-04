import Upload from "~/api/upload";
import Contact from "~/api/mentor";
import News from "~/api/news";
import Product from "~/api/product";
import Activity from "~/api/activity";
import Job from "~/api/job";
import Application from "~/api/application";
import Service from "~/api/service";
// For subitem
import NewsCategory from "~/api/news-category";
import ContactSubject from "~/api/contact-subject";
import ServiceCategory from "~/api/service-category";
import Position from "~/api/application-position";
import Appointment from "~/api/appointment";

import Auth from "~/api/auth";

const axios = require("axios").default;

const instance = axios.create({
  baseURL: process.env.BASE_URL_API,
});

export default (context, inject, store) => {
  // Initialize API factories
  const factories = {
    upload: Upload(context.$axios, instance),
    contact: Contact(context.$axios, instance),
    news: News(context.$axios, instance),
    product: Product(context.$axios, instance),
    activity: Activity(context.$axios, instance),
    job: Job(context.$axios, instance),
    application: Application(context.$axios, instance),
    service: Service(context.$axios, instance),
    auth: Auth(context.$axios, instance),
    // For subitem
    newsCategory: NewsCategory(context.$axios, instance),
    contactSubject: ContactSubject(context.$axios, instance),
    serviceCategory: ServiceCategory(context.$axios, instance),
    position: Position(context.$axios, instance),
    appointment: Appointment(context.$axios, instance),
  };

  // Inject $api
  inject("api", factories);
};
