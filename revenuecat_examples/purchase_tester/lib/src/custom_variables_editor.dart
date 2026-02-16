import 'package:flutter/material.dart';

/// A widget that allows editing custom variables for paywall text substitution.
/// Variables can be used in paywalls with the `{{ custom.variable_name }}` syntax.
class CustomVariablesEditor extends StatefulWidget {
  final Map<String, dynamic> variables;
  final ValueChanged<Map<String, dynamic>> onVariablesChanged;

  const CustomVariablesEditor({
    Key? key,
    required this.variables,
    required this.onVariablesChanged,
  }) : super(key: key);

  @override
  State<CustomVariablesEditor> createState() => _CustomVariablesEditorState();
}

class _CustomVariablesEditorState extends State<CustomVariablesEditor> {
  late List<MapEntry<String, dynamic>> _variablesList;

  @override
  void initState() {
    super.initState();
    _variablesList = widget.variables.entries.toList();
  }

  @override
  void didUpdateWidget(CustomVariablesEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.variables != widget.variables) {
      _variablesList = widget.variables.entries.toList();
    }
  }

  void _addVariable() {
    showDialog(
      context: context,
      builder: (context) => _AddVariableDialog(
        onAdd: (key, value) {
          setState(() {
            _variablesList.add(MapEntry(key, value));
            _variablesList.sort((a, b) => a.key.compareTo(b.key));
          });
          _notifyChanged();
        },
        existingKeys: _variablesList.map((e) => e.key).toSet(),
      ),
    );
  }

  void _editVariable(int index) {
    final entry = _variablesList[index];
    showDialog(
      context: context,
      builder: (context) => _EditVariableDialog(
        initialKey: entry.key,
        initialValue: entry.value,
        onSave: (key, value) {
          setState(() {
            _variablesList[index] = MapEntry(key, value);
            _variablesList.sort((a, b) => a.key.compareTo(b.key));
          });
          _notifyChanged();
        },
        existingKeys: _variablesList
            .where((e) => e.key != entry.key)
            .map((e) => e.key)
            .toSet(),
      ),
    );
  }

  void _deleteVariable(int index) {
    setState(() {
      _variablesList.removeAt(index);
    });
    _notifyChanged();
  }

  void _notifyChanged() {
    widget.onVariablesChanged(Map.fromEntries(_variablesList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Variables'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addVariable,
            tooltip: 'Add Variable',
          ),
        ],
      ),
      body: _variablesList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.code,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No custom variables',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a variable',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Use {{ custom.variable_name }} in paywalls',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _variablesList.length,
              itemBuilder: (context, index) {
                final entry = _variablesList[index];
                return Dismissible(
                  key: Key(entry.key),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => _deleteVariable(index),
                  child: ListTile(
                    title: Text(
                      entry.key,
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                    subtitle: Text(
                      entry.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withAlpha(25),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'String',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () => _editVariable(index),
                        ),
                      ],
                    ),
                    onTap: () => _editVariable(index),
                  ),
                );
              },
            ),
    );
  }
}

class _AddVariableDialog extends StatefulWidget {
  final void Function(String key, String value) onAdd;
  final Set<String> existingKeys;

  const _AddVariableDialog({
    required this.onAdd,
    required this.existingKeys,
  });

  @override
  State<_AddVariableDialog> createState() => _AddVariableDialogState();
}

class _AddVariableDialogState extends State<_AddVariableDialog> {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();
  String? _keyError;

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _validateAndAdd() {
    final key = _keyController.text.trim();
    final value = _valueController.text;

    if (key.isEmpty) {
      setState(() => _keyError = 'Variable name is required');
      return;
    }

    if (!_isValidVariableName(key)) {
      setState(() => _keyError =
          'Must start with letter, only alphanumeric and underscores');
      return;
    }

    if (widget.existingKeys.contains(key)) {
      setState(() => _keyError = 'Variable already exists');
      return;
    }

    widget.onAdd(key, value);
    Navigator.of(context).pop();
  }

  bool _isValidVariableName(String name) {
    if (name.isEmpty) return false;
    // Variable names must start with a letter and contain only
    // alphanumeric characters and underscores
    return RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Variable'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _keyController,
            decoration: InputDecoration(
              labelText: 'Variable Name',
              hintText: 'e.g., player_name',
              errorText: _keyError,
            ),
            onChanged: (_) => setState(() => _keyError = null),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueController,
            decoration: const InputDecoration(
              labelText: 'Value',
              hintText: 'e.g., John',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _validateAndAdd,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class _EditVariableDialog extends StatefulWidget {
  final String initialKey;
  final String initialValue;
  final void Function(String key, String value) onSave;
  final Set<String> existingKeys;

  const _EditVariableDialog({
    required this.initialKey,
    required this.initialValue,
    required this.onSave,
    required this.existingKeys,
  });

  @override
  State<_EditVariableDialog> createState() => _EditVariableDialogState();
}

class _EditVariableDialogState extends State<_EditVariableDialog> {
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;
  String? _keyError;

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController(text: widget.initialKey);
    _valueController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _validateAndSave() {
    final key = _keyController.text.trim();
    final value = _valueController.text;

    if (key.isEmpty) {
      setState(() => _keyError = 'Variable name is required');
      return;
    }

    if (!_isValidVariableName(key)) {
      setState(() => _keyError =
          'Must start with letter, only alphanumeric and underscores');
      return;
    }

    if (widget.existingKeys.contains(key)) {
      setState(() => _keyError = 'Variable already exists');
      return;
    }

    widget.onSave(key, value);
    Navigator.of(context).pop();
  }

  bool _isValidVariableName(String name) {
    if (name.isEmpty) return false;
    // Variable names must start with a letter and contain only
    // alphanumeric characters and underscores
    return RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Variable'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _keyController,
            decoration: InputDecoration(
              labelText: 'Variable Name',
              errorText: _keyError,
            ),
            onChanged: (_) => setState(() => _keyError = null),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueController,
            decoration: const InputDecoration(
              labelText: 'Value',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _validateAndSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
