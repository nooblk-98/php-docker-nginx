module.exports = {
  apps: [
    {
      name: "php-fpm",
      script: "php-fpm",
      args: "-F",
      interpreter: "none"
    },
    {
      name: "nginx",
      script: "nginx",
      args: "-g 'daemon off;'",
      interpreter: "none"
    }
  ]
};
