{...}: {
  perSystem = {inputs', ...}: {
    apps.expy = inputs'.expy.apps.default;
  };
}
