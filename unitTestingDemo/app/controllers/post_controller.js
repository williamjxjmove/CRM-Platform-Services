load('application');

action('title', function () {
  render({
    title: "post#title"
  });
});

action('content', function () {
  render({
    title: "post#content"
  });
});

action('createAt:date', function () {
  render({
    title: "post#createAt:date"
  });
});