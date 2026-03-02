{...}: {
  perSystem = {inputs', ...}: {
    devShells.expy = inputs'.expy.devShells.default;
  };
}
