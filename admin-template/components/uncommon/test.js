// /* eslint-disable no-unused-vars */
// function checkContentBetweenHtmlTags(string) {
//   const regexSplitPair = /(<.*?>)([\s\S]*?)(<\/.*?>)/g;
//   const tagPairs = string.match(regexSplitPair);
//   for (let i = 0; i < tagPairs.length; i++) {
//     const regexSpaceInside = /<.*>(\s*)<\/.*>/g;
//     if (!regexSpaceInside.test(tagPairs[i])) {
//       console.error(tagPairs[i], "false");
//       return false;
//     }
//   }
//   console.log(tagPairs); // ["<h1> </h1>", "<p> </p>", "<p>hehhe </p>"]
//   return true;
// }
// checkContentBetweenHtmlTags("<h1> </h1><p> </p><p> </p>")
