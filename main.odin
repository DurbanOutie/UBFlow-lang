package main

import "core:fmt"
import "core:os"
import "core:bufio"
import "core:strings"

run_file :: proc(path:string){

    data, ok := os.read_entire_file(path)
    defer delete(data)
    //run(data)
    fmt.printf("%s", data)
}

run_prompt :: proc(){

    r : bufio.Reader
    buffer : [1<<8]byte
    bufio.reader_init_with_buf(&r, os.stream_from_handle(os.stdin), buffer[:])

    defer bufio.reader_destroy(&r)

    for{

        fmt.print("> ")

        line, err := bufio.reader_read_string(&r, '\n')
        defer delete(line)
        line = strings.trim_right(line, "\r")

        if len(line) == 1{
            fmt.printfln("Exiting command mode")
            break;
        }

        //run(line)
        fmt.printfln("Echo command: %s", line)

    }


    
}


main :: proc(){

    args : []string = os.args[1:]

    if len(args) > 1{
       fmt.eprintfln("Usage: UBFlow [script]") 
    }else if len(args) == 1{
        run_file(args[0])
    }else{
        run_prompt();
    }

}
