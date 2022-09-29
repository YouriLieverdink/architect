import 'dart:convert';
import 'dart:io';

extension Overwritable on File {
  ///
  Future<File> createOrOverwrite({
    bool recursive = false,
  }) async {
    //
    if (await exists()) {
      // We temporarely remove the file if it exists.
      await delete(recursive: recursive);
    }

    await create(recursive: recursive);

    return this;
  }

  ///
  File createOrOverwriteSync({
    bool recursive = false,
  }) {
    //
    if (existsSync()) {
      // We temporarely remove the file if it exists.
      deleteSync(recursive: recursive);
    }

    createSync(recursive: recursive);

    return this;
  }
}

extension JsonReadable on File {
  ///
  Future<dynamic> readAsJson() async {
    //
    final source = await readAsString();

    return jsonDecode(source);
  }

  ///
  dynamic readAsJsonSync() {
    //
    final source = readAsStringSync();

    return jsonDecode(source);
  }
}
