open Cmdliner

let help_secs = [
	`S "MORE HELP";
	`P "Use `$(mname) $(i,command) --help' for help on a single command.";
	`Noblank;
]

let default_cmd =
	let doc = "RRD protocol reader" in
	let man = help_secs in
	Term.(ret (pure (fun _ -> `Help (`Pager, None)) $ pure ())),
	Term.info "reader" ~version:"0.1" ~doc ~man

let read_file_cmd =
	let path =
		let doc = "The path of the file to read" in
		Arg.(required & pos 0 (some string) None & info [] ~docv:"FILE" ~doc)
	in
	let protocol =
		let doc = "The protocol to use to read the rrd data" in
		Arg.(required & pos 1 (some string) None & info [] ~docv:"PROTOCOL" ~doc)
	in
	let doc = "read from a file" in
	let man = [
		`S "DESCRIPTION";
		`P "Read rrd data from a file, using the specified protocol"
	] @ help_secs in
	Term.(pure Reader_commands.read_file $ path $ protocol),
	Term.info "file" ~doc ~man

let cmds = [
	read_file_cmd
]

let () =
	match Term.eval_choice default_cmd cmds with
	| `Error _ -> exit 1
	| _ -> exit 0