String addExtraNewline(String input) {
  // Use a regular expression to find every occurrence of ".\n"
  return input.replaceAllMapped(RegExp(r'\.\n'), (match) {
    // Add an extra newline before the matched string
    return '${match.group(0)}\n';
  }).replaceAllMapped(
    RegExp(r'\”\n'),
    (match) {
      // Add an extra newline before the matched string
      return '${match.group(0)}\n';
    },
  );
}

String breakLongLines(String input) {
  // Split the input into lines, preserving existing newlines
  // return input;
  int n = 105;
  List<String> lines = input.split('\n');

  // Create a new list to hold the processed lines
  List<String> processedLines = [];

  for (String line in lines) {
    // If the line exceeds 95 characters, break it into multiple lines
    while (line.length > n) {
      // Find the last space within the first 95 characters to break the line
      int breakIndex = line.lastIndexOf(' ', n);
      if (breakIndex == -1) {
        // If no space is found, break at 95 characters
        breakIndex = n;
      }
      // Add the broken line to the processed lines
      processedLines.add(line.substring(0, breakIndex));
      // Update the line to the remaining part
      line = line.substring(breakIndex).trim();
    }
    // Add the remaining part of the line (if any) to the processed lines

    processedLines.add(line);
  }

  // Join the processed lines back into a single string with newlines
  return processedLines.join('\n');
}
