import 'package:flutter/material.dart';

class AddGoalDialog extends StatefulWidget {
  const AddGoalDialog({super.key});

  @override
  State<AddGoalDialog> createState() => _AddGoalDialogState();
}

class _AddGoalDialogState extends State<AddGoalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  int _duration = 30;
  bool _isGroup = false;
  int _maxParticipants = 10;
  DateTime _startDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '새로운 목표',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '목표 제목',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '목표 제목을 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // 시작일시 선택 필드
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: '시작일시',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_startDate.year}년 ${_startDate.month}월 ${_startDate.day}일',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _duration,
                decoration: const InputDecoration(
                  labelText: '기간',
                  border: OutlineInputBorder(),
                ),
                items: [7, 14, 21, 30, 60, 90]
                    .map((days) => DropdownMenuItem(
                          value: days,
                          child: Text('$days일'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _duration = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              // 그룹 설정
              SwitchListTile(
                title: const Text('그룹 목표로 설정'),
                subtitle: Text(
                  _isGroup ? '다른 사람들과 함께 목표를 달성해보세요' : '개인 목표로 설정됩니다',
                ),
                value: _isGroup,
                onChanged: (value) {
                  setState(() {
                    _isGroup = value;
                  });
                },
              ),
              if (_isGroup) ...[
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _maxParticipants,
                  decoration: const InputDecoration(
                    labelText: '최대 참여 인원',
                    border: OutlineInputBorder(),
                  ),
                  items: [5, 10, 20, 30, 50]
                      .map((count) => DropdownMenuItem(
                            value: count,
                            child: Text('$count명'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _maxParticipants = value;
                      });
                    }
                  },
                ),
              ],
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context, {
                          'title': _titleController.text,
                          'duration': _duration,
                          'isGroup': _isGroup,
                          'maxParticipants': _isGroup ? _maxParticipants : null,
                          'startDate': _startDate,
                        });
                      }
                    },
                    child: const Text('추가'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
