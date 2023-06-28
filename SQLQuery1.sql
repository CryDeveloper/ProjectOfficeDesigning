--create trigger Project_Create
--on Project
--after insert
--as
--update Project
--set Project.CreatedTime = GETDATE()
--where id=(select Project.Id from inserted);

alter trigger Task_Create
on Task 
for insert
as 
	update Task
	set Task.CreatedTime = GETDATE(),
	Task.ShortTitle = Concat((select ShortTitle from Project where Project.Id = (select Task.ProjectId from inserted)),'-', (select count(t1.Id) from Task t1 where t1.ProjectId = (select Task.ProjectId from inserted)))
	where id=(select Task.Id from inserted)

--alter trigger Task_Update on Task
--for update 
--as 
--	--update Task
--	--set Task.UpdatedTime = GETDATE()
--	--where Task.Id =(select Task.Id from inserted)
--if update(StatusId)
--	Insert into StoryTaskStatus (StoryTaskStatus.TaskId, StoryTaskStatus.StatusId, StoryTaskStatus.UpdatedTimeStatus)
--	values ((select Id from inserted), (select StatusId from inserted), GETDATE())

--alter trigger StoryStatus_Update
--on Task
--after update
--as if update(StatusId)
--begin
--	Insert into StoryTaskStatus (StoryTaskStatus.TaskId, StoryTaskStatus.StatusId, StoryTaskStatus.UpdatedTimeStatus)
--	values ((select Id from inserted), (select StatusId from inserted), GETDATE())
--end;

--drop trigger Task_Update


