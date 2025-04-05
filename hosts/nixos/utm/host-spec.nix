{...}: {
  hostSpec = {
    hostName = "utm";
    userName = "s33d";
    githubUser = "abstracts33d";
    githubEmail = "abstract.s33d@gmail.com";
    networking = {
      interface = "enp0s1";
    };

    isImpermanent = true;
    isDev = false;

    useHyprland = true;
    useSddm = true;
  };
}
