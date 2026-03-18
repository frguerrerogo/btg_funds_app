import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('No commit message file provided.');
    exit(1);
  }

  final commitMsgFile = File(args[0]);
  final rawContent = commitMsgFile.readAsStringSync();

  // Filter out comment lines (starting with #)
  final message = rawContent.split('\n').where((line) => !line.startsWith('#')).join('\n').trim();

  final conventionalCommitRegex = RegExp(
    r'^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .+',
  );

  if (!conventionalCommitRegex.hasMatch(message)) {
    print('❌ Commit message must follow Conventional Commits.');
    print('💡 Example: feat(auth): add login validation');
    exit(1);
  }

  print('✅ Commit message is valid.');
}
