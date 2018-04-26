//print("Hello, world! lt")
////使用图片的方式 sb imageNamed
////--project
////--resource-extensions
////file-extensions
//
////main(int argc, char *argv)
//
//print(CommandLine.arguments)

import Foundation
import CommandLineKit
import Rainbow

let cli = CommandLineKit.CommandLine()

let projectOption = StringOption(shortFlag: "p", longFlag: "project",
                            helpMessage: "Path to the project.")
let excludePaths = MultiStringOption(shortFlag: "e", longFlag: "exclude",
                                     helpMessage: "Exclude Path to the search.")
let resourceExtensionOption = MultiStringOption(shortFlag: "r", longFlag: "resource-extensions",
                          helpMessage: "esource Extension to search.")
let fileExtensionsOption = MultiStringOption(shortFlag: "f", longFlag: "file-extensions",
                                             helpMessage: "File Extension to search.")
let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")

cli.addOptions(projectOption, resourceExtensionOption, fileExtensionsOption, help)
cli.formatOutput = { s, type in
    var str: String
    switch(type) {
    case .error:
        str = s.red.bold
    case .optionFlag:
        str = s.green.underline
    case .optionHelp:
        str = s.lightYellow
    default:
        str = s
    }
    return cli.defaultFormat(s: str, type: type)
}

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
}

if help.value {
    cli.printUsage()
    exit(EX_OK)
}

let project = projectOption.value ?? "."
let resource = resourceExtensionOption.value ?? ["png","jpg", "imageset"]
let flieExtensions = fileExtensionsOption.value ?? ["swift", "m", "mm", "xib", "storyboard"]


