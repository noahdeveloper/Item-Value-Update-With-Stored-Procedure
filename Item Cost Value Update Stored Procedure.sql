-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Noe Pineda>
-- Create date: <2020-01-01>
-- Description:	<Update item cost>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateItemCost]
	@UpdateAllItems BIT,
	@ItemToUpdate INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Stored procedure name
	DECLARE
	@StoredProcedureName VARCHAR(255)
	SET @StoredProcedureName = 'sp_UpdateItemCost'

	--Cursor
    DECLARE 
	@ItemCursor CURSOR,
	@CurrentItemID INT
	
	IF @UpdateAllItems = 1
	BEGIN
		SET @ItemCursor = CURSOR FOR
		(
			SELECT ItemID
			FROM Item
			WHERE Active = 1
		)
	END
	ELSE --IF @UpdateAllItems <> 1
	BEGIN
		SET @ItemCursor = CURSOR FOR
		(
			SELECT ItemID
			FROM Item
			WHERE ItemID = @ItemToUpdate
			AND Active = 1
		)
	END

	OPEN @ItemCursor
	FETCH NEXT FROM @ItemCursor INTO @CurrentItemID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT('Current ItemID: ' + CONVERT(NVARCHAR, @CurrentItemID))

		--IDs
		DECLARE 
		@LaborCostID INT,
		@MaterialCostID INT,
		@DiscountID INT,
		@ProfitID INT

		SET @LaborCostID = (SELECT LaborCostID FROM Item WHERE ItemID = @CurrentItemID)
		SET @MaterialCostID = (SELECT MaterialCostID FROM Item WHERE ItemID = @CurrentItemID)
		SET @DiscountID = (SELECT DiscountID FROM Item WHERE ItemID = @CurrentItemID)
		SET @ProfitID = (SELECT ProfitID FROM Item WHERE ItemID = @CurrentItemID)

		--Amounts
		DECLARE 
		@LaborCost DECIMAL(19,4),
		@MaterialCost DECIMAL(19,4),
		@Discount DECIMAL(19,4),
		@Profit DECIMAL(19,4),
		@OriginalCost DECIMAL(19,4),
		@UpdatedCost DECIMAL(19,4)

		SET @OriginalCost = (SELECT TotalCost FROM Item WHERE ItemID = @CurrentItemID)

		SET @LaborCost = (SELECT TotalCost FROM LaborCost WHERE LaborCostID = @LaborCostID)
		SET @MaterialCost = (SELECT TotalCost FROM MaterialCost WHERE MaterialCostID = @MaterialCostID)
		SET @Discount = (SELECT Amount FROM Discount WHERE DiscountID = @DiscountID)
		SET @Profit = (SELECT Amount FROM Profit WHERE ProfitID = @ProfitID)

		SET @UpdatedCost = ((@LaborCost + @MaterialCost + @Profit) - @Discount)

		PRINT('Original TotalCost: ' + CONVERT(NVARCHAR, @OriginalCost))

		UPDATE Item
		SET TotalCost = @UpdatedCost
		WHERE ItemID = @CurrentItemID

		PRINT('Updated TotalCost: ' + CONVERT(NVARCHAR, @UpdatedCost))

		--line break for readability
		PRINT('
		')

		FETCH NEXT FROM @ItemCursor INTO @CurrentItemID 
	END
	CLOSE @ItemCursor
	DEALLOCATE @ItemCursor

END
GO
