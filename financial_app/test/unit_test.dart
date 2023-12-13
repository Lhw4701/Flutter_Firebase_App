import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_app/model/widgets.dart'; // Replace with your actual file structure

void main() {
  testWidgets('CustomTextField renders correctly', (WidgetTester tester) async {
    final controller = TextEditingController();
    final prefixIcon = Icons.email;
    final labelText = 'Email';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            controller: controller,
            prefixIcon: prefixIcon,
            labelText: labelText,
          ),
        ),
      ),
    );

    expect(find.text(labelText), findsOneWidget);
    expect(find.byIcon(prefixIcon), findsOneWidget);
  });

  testWidgets('ItemDialog calls onAddItem when Add button is pressed',
          (WidgetTester tester) async {
        final itemController = TextEditingController();
        final priceController = TextEditingController();
        String? addedItem;
        String? addedPrice;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ItemDialog(
                itemController: itemController,
                priceController: priceController,
                onAddItem: (item, price) {
                  addedItem = item;
                  addedPrice = price;
                },
              ),
            ),
          ),
        );

        // Enter some text in the item and price fields
        await tester.enterText(find.byKey(const Key('item')), 'Test Item');
        await tester.enterText(find.byKey(const Key('price')), '42');

        // Tap the Add button
        await tester.tap(find.byKey(const Key('add')));
        await tester.pump();

        // Verify that onAddItem was called with the correct values
        expect(addedItem, 'Test Item');
        expect(addedPrice, '42');
      });
}


