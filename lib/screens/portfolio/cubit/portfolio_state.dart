import '../models/portfolio_data_model.dart';

abstract class PortfolioState {
  const PortfolioState();
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioLoaded extends PortfolioState {
  final PortfolioDataModel data;

  const PortfolioLoaded(this.data);
}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);
}
