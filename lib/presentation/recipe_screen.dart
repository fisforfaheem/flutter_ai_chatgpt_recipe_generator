import 'package:flutter/material.dart';
import 'package:flutter_ai_chatgpt_recipe_generator/functions/response.dart'; // Importing Flutter Material Design library

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() =>
      _RecipeScreenState(); // Creating the state for this widget
}

class _RecipeScreenState extends State<RecipeScreen> {
  late final TextEditingController controller; // Controller for the text field
  late final FocusNode focusNode; // Focus node for the text field
  final List<String> ingredients = <String>[]; // List to store the ingredients
  String response = ''; // String to store the response from the AI

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(); // Initializing the text controller
    focusNode = FocusNode(); // Initializing the focus node
  }

  @override
  void dispose() {
    controller.dispose(); // Disposing the text controller when not needed
    focusNode.dispose(); // Disposing the focus node when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magic AI Recipe App'), // App bar title
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  'Find your recipe by typing your ingredients!'), // Instruction text
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: controller, // Assigning the controller
                      focusNode: focusNode, // Assigning the focus node
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Type Your Ingredients', // Placeholder text
                      ),
                      onFieldSubmitted: (String value) {
                        // Action on submit
                        setState(() {
                          ingredients
                              .add(value); // Adding the ingredient to the list
                          controller.clear(); // Clearing the text field
                          focusNode
                              .requestFocus(); // Requesting focus for the text field
                        });
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Action on button press
                      setState(() {
                        ingredients.add(controller
                            .text); // Adding the ingredient to the list
                        controller.clear(); // Clearing the text field
                        focusNode
                            .requestFocus(); // Requesting focus for the text field
                      });
                    },
                    child: const Icon(Icons.add), // Button icon
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Wrap(
                spacing: 8.0,
                children: [
                  for (final String ingredient
                      in ingredients) // Looping through the ingredients list
                    Chip(
                      label: Text(ingredient), // Displaying the ingredient
                      onDeleted: () {
                        // Action on delete
                        setState(() {
                          ingredients.remove(
                              ingredient); // Removing the ingredient from the list
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                  child: SizedBox(
                child: Text(response), // Displaying the response from the AI
              )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Action on button press
                      setState(() => response =
                          'Thinking'); // Updating the response to 'Thinking'
                      dynamic temp = await Response().askAi(ingredients.join(
                          ingredients
                              .toString())); // Asking the AI for a recipe
                      print(temp);
                      setState(() => response = temp
                          .toString()); // Updating the response with the AI's response
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.create), // Button icon
                        Text('Create Recipe'),
                      ],
                    ), // Button text
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
