let root = Dream.get "/"
  (fun _ -> 
    Dream.html "Good morning, world!")

let echo = Dream.get "/echo/:word"
  (fun request -> 
    Dream.html (Dream.param request "word"))

let () =
  Dream.run 
    @@ Dream.logger
    @@ Dream.router [
      root;
      echo 
  ]
