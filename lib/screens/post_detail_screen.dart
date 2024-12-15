import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/blocs/post_bloc.dart';
import '../shared/models/Post.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.title);
    _descriptionController = TextEditingController(text: widget.post.description);
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _submitUpdate() {
    if (_formKey.currentState!.validate()) {
      final updatedPost = Post(
        id: widget.post.id, // L'ID reste inchangé
        title: _titleController.text,
        description: _descriptionController.text,
      );

      // Envoie l'événement UpdatePost au Bloc
      context.read<PostBloc>().add(UpdatePost(updatedPost: updatedPost));

      // Sortir du mode édition
      setState(() {
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Modifier le post' : 'Détail du post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Champ pour le titre (modifiable ou non selon le mode)
              if (!_isEditing)
                Text(
                  _titleController.text,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )
              else
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Titre',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Le titre ne peut pas être vide' : null,
                ),
              const SizedBox(height: 20),

              // Champ pour la description (modifiable ou non selon le mode)
              if (!_isEditing)
                Text(
                  _descriptionController.text,
                  style: const TextStyle(fontSize: 16),
                )
              else
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'La description ne peut pas être vide' : null,
                ),
              if (_isEditing)
                const SizedBox(height: 20),

              // Bouton pour valider les modifications en mode édition
              if (_isEditing)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitUpdate,
                    child: const Text('Enregistrer les modifications'),
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleEditMode,
        child: Icon(_isEditing ? Icons.check : Icons.edit),
        tooltip: _isEditing ? 'Valider' : 'Modifier',
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
