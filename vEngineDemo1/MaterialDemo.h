#pragma once
#include "vDrawableComponent.h"

using namespace vEngine;

namespace vEngine
{
	class Effect;
	class BasicMaterial;
}

namespace Rendering
{
	class MaterialDemo : public DrawableComponent
	{
		RTTI_DECLARATIONS(MaterialDemo, DrawableComponent)

	public:
		MaterialDemo(Engine& game, Camera& camera);
		~MaterialDemo();

		virtual void Initialize() override;
		virtual void Draw(const Time& gameTime) override;

	private:
		MaterialDemo();
		MaterialDemo(const MaterialDemo& rhs);
		MaterialDemo& operator=(const MaterialDemo& rhs);

		Effect* mBasicEffect;
		BasicMaterial* mBasicMaterial;
		ID3D11Buffer* mVertexBuffer;
		ID3D11Buffer* mIndexBuffer;
		UINT mIndexCount;

		XMFLOAT4X4 mWorldMatrix;
	};
}
