class Task {
  final TaskStatus status;
  final dynamic payload;

  const Task({
    this.status,
    this.payload,
  });

  const Task.idle() : this(status: TaskStatus.idle);
  const Task.running() : this(status: TaskStatus.running);
  const Task.failed({payload}) : this(status: TaskStatus.failed, payload: payload);
  const Task.successful({payload}) : this(status: TaskStatus.successful, payload: payload);

  bool get notIdle => status != TaskStatus.idle;
  bool get isRunning => status == TaskStatus.running;
  bool get notRunning => status != TaskStatus.running;
  bool get isSuccessful => status == TaskStatus.successful;
  bool get isFailed => status == TaskStatus.failed;
  bool get isFinished => isSuccessful || isFailed;
  bool get notFinished => !isFinished;

  bool operator ==(o) => o is Task && o.status == status;
  int get hashCode => status.hashCode;
}

enum TaskStatus {
  idle,
  running,
  successful,
  failed,
}
