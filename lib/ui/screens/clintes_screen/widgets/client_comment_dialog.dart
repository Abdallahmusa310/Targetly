import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/screens/auth_screens/reset_password_screen/confirm_message.dart';

class ClientCommentdialog extends StatefulWidget {
  const ClientCommentdialog({super.key, required this.client});
  final ClinetModel client;

  @override
  State<ClientCommentdialog> createState() => _ClientCommentdialogState();
}

class _ClientCommentdialogState extends State<ClientCommentdialog> {
  final TextEditingController _controller = TextEditingController();
  int? _editingIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.comment, color: Color(0xFF7F73E6)),
                const SizedBox(width: 8),
                Text(
                  '${widget.client.clinetname} - Comments',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),

            // list of comments
            widget.client.comments.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'No comments yet',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                : ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.client.comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          leading: CircleAvatar(
                            radius: 12,
                            backgroundColor: const Color(0xFF7F73E6),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          title: Text(widget.client.comments[index]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _editingIndex = index;
                                    _controller.text =
                                        widget.client.comments[index];
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 18,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) => ConfirmMessage(
                                      onConfirm: () async {
                                        Navigator.pop(dialogContext);
                                        await context
                                            .read<ClinetCubit>()
                                            .deleteComment(
                                              widget.client,
                                              index,
                                            );
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),

            // add/edit comment field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _editingIndex != null
                          ? 'Edit comment...'
                          : 'Add comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return;

                    if (_editingIndex != null) {
                      context.read<ClinetCubit>().editComment(
                        widget.client,
                        _editingIndex!,
                        _controller.text.trim(),
                      );
                      setState(() => _editingIndex = null);
                    } else {
                      context.read<ClinetCubit>().addComment(
                        widget.client,
                        _controller.text.trim(),
                      );
                      setState(() {});
                    }
                    _controller.clear();
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xFF7F73E6),
                    foregroundColor: Colors.white,
                  ),
                  icon: Icon(_editingIndex != null ? Icons.check : Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
