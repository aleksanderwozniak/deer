import 'package:tasking/data/dao/archive_dao.dart';
import 'package:tasking/data/dao/todo_dao.dart';

class Dao {
  final TodoDao todoDao;
  final ArchiveDao archiveDao;

  Dao()
      : todoDao = TodoDao(),
        archiveDao = ArchiveDao();
}
