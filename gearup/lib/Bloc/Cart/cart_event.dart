part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class OnSelectCardEvent extends CartEvent {
  final CreditCard creditCardFrave;

  OnSelectCardEvent(this.creditCardFrave);
}

class OnCancelCart extends CartEvent {}

class OnMakePaymentEvent extends CartEvent {
  final String amount;
  final CreditCard creditCardFrave;

  OnMakePaymentEvent({required this.amount, required this.creditCardFrave});
}
